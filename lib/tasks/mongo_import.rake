# coding: UTF-8
#
# 以下为 Rake 任务，功能是将普通文件系统里面的东西转移到 MongoDB GridFS 里面
# 此代码片段来自于 Homeland 项目： https://github.com/huacnlee/homeland/tree/mysql
# 场景：
# 老架构 Linux File Store, Paperclip, hash 目录:"https://github.com/huacnlee/homeland/blob/ca0bdd8ab26da7b780e2dae7eba12b79f41e6d65/config/initializers/paperclip_hashpath.rb"
# 新架构 Mongodb GridFS, Garrierwave, 继续沿用 Paperclip 目录兼容: https://github.com/huacnlee/homeland/tree/7100ce4c506cc2c4387f25e50c533e5bbcac6cc2/app/uploaders
# 整个过程不会修改任何原始数据库和上传文件
#
require 'mongo'
include Mongo
namespace :gridfs do
  task :import => :environment do
    # 这里将图片读取并转入 GridFS 的过程抽象为 GridFsImporter，见下面
    @grid = GridFsImporter.new


    # 处理 Photo 表的
    puts "-"*120
    puts "Import Photos"
    # 定义原来的几种图片个规格,分别载入
    photos_styles = %w(thumb medium  large original)
    EydAvatar.all(:conditions => 'avatar_file_name is not null').each do |photo|
      photos_styles.each do |style|
        @grid.put(photo, style)
      end
    end

    # 处理 User 表
#    puts "-"*120
#    puts "Import Users"
#    avatars_styles = %w(small normal large original)
#    User.all(:conditions => 'avatar is not null').each do |user|
#      avatars_styles.each do |style|
#        @grid.put(user, 'avatar', style)
#      end
#    end

  end
end


# 图片读取并转入 GridFS
class GridFsImporter
  def initialize
    @grid = Grid.new(Mongoid.database)
  end

  def put(model,style)
    print "#{model.class.to_s}: #{model.id} ..."
    # Hash path, 我这个是在 BaseUploader 里面定义个一个按照之前 paperclip 那中目录生成方法写的
    #hashed_path = BaseUploader.new.hashed_path(model.id)
    # file_name 的定义格式要按照原来 Paperclip 的标准定义，这样在网站正文中插入的图片就不会受到影响，图片地址通通不变
    file_name = "#{style}_#{model.avatar_file_name}"
    # 实际的文件地址，我在 APP_CONFIG['upload_root'] 里面配置了上传的根目录
    real_file_name = File.join("/home/tim/Documents/everyday/public/system/pictures/#{model.id}/",file_name)

    begin
      f = File.open(real_file_name)
    rescue => e
      puts "** [Error] open file error: #{e}"
    end

    # 检查有没有同样的，如果有，就不用插入了（一来可以防止重复图片，而来如果转移过程中断，之前加过的就不会再次加入）
    if old = @grid.exist?({'filename' => file_name})
      puts "-- skip, old #{old['filename']} existed."
    else
      begin
        # 向 GridFS 提交文件
        id = @grid.put(File.open(real_file_name), :filename => file_name)
        puts "#{file_name} saved."
      rescue => e
        puts "** [GridFS] save file error: #{e}"
      end
    end

  end
end
