class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :destroy]

  def index
    @searches = Search.page(params[:page])
  end

  def show
    @products = Product.where(@search.condition_array).order(@search.order_str).page(params[:page])
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search result.' }
        format.json { render action: 'show', status: :created, location: @search }
      else
        format.html { redirect_to products_path, notice: 'Failed to search' }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:pre_condition, :field, :comparison, :value,
                                      :sort_by, :sort_direction,
                                      connections_attributes: [
                                        :id, :_destroy,
                                        :connector,
                                        :pre_condition, :field, :comparison, :value
                                      ])
    end
end
