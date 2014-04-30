class HashtagsController < ApplicationController
  before_action :get_classroom

  def show
    if params[:hashtag]
      params[:hashtag] = params[:hashtag].gsub(/^#/, '')
    else
      params[:hashtag] = ''
    end
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    @hashtagged = @hashtag.hashtaggables.select { |obj| obj.classroom_id == @classroom.id } if @hashtag
  end

end
