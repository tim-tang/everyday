class EydCommentController < ApplicationController
  before_filter :authorize
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
end
