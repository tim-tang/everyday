class EydCommentController < ApplicationController
  skip_before_filter :authorize, :only => [:create]
  layout 'admin'

  def index
    @total_comments = EydComment.paginate_by_sql ["select comment.* from eyd_comments comment order by comment.updated_at desc"], :page => params[:page], :per_page=>20
  end

  def destroy
    if params[:comment_ids] != nil
      params[:comment_ids].each do |comment_id|
        @eyd_comment = EydComment.find(comment_id)
        @eyd_comment.destroy
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
        format.html { redirect_to(show_blog_path(@eyd_comment.blog_id), :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @eyd_comment, :status => :created }
      else
        format.html { redirect_to(show_blog_path(@eyd_comment.blog_id))}
        format.xml  { render :xml => @eyd_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

end
