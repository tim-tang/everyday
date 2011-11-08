class EydCommentController < ApplicationController
  skip_before_filter :authorize, :only => [:create]
  layout 'admin'
  cache_sweeper :eyd_comment_sweeper, :only=>[:create]

  def index
    @total_comments = EydComment.fetch_admin_comments(params[:page])
  end

  def destroy
    if params[:comment_ids] != nil
      params[:comment_ids].each do |comment_id|
        @eyd_comment = EydComment.find(comment_id)
        @eyd_comment.destroy
        expire_fragment 'comment_fragment'
        if @eyd_comment !=nil
          #expire cached_comment for postmeta
          Rails.cache.delete("#{@eyd_comment.blog_id}_comments")
        end
      end
    end
    respond_to do |format|
      format.html {redirect_to(comment_index_path)}
      format.xml {head ok}
    end
  end

  def create
    @eyd_comment = EydComment.new(params[:eyd_comment])
    respond_to do |format|
      if @eyd_comment.save
        if @eyd_comment.is_guestbook ==true
          format.html { redirect_to(guest_book_path, :notice => 'Category was successfully created.') }
        else
          #expire cached_comment for postmeta
          Rails.cache.delete("#{@eyd_comment.blog_id}_comments")
          format.html { redirect_to(show_blog_path(@eyd_comment.blog_id), :notice => 'Category was successfully created.') }
        end
        format.xml  { render :xml => @eyd_comment, :status => :created }
      else
        if @eyd_comment.is_guestbook ==true
          format.html { redirect_to(guest_book_path)}
        else
          format.html { redirect_to(show_blog_path(@eyd_comment.blog_id))}
        end
        format.xml  { render :xml => @eyd_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

end
