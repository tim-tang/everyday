class EydfGalleryController < ApplicationController
  skip_before_filter :authorize

  def gallery_list
    @total_avatars = EydAvatar.where(:user_id=>1).order('updated_at desc').limit(280)
  end

  def tag_gallery_list
    @total_avatars = EydAvatar.tagged_with(params[:id])
  end
end
