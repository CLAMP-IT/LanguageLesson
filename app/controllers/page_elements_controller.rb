class PageElementsController < ApplicationController
  # GET /page_elements
  # GET /page_elements.json
  def index
    @page_elements = PageElement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @page_elements }
    end
  end

  # GET /page_elements/1
  # GET /page_elements/1.json
  def show
    @page_element = PageElement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page_element }
    end
  end

  # GET /page_elements/new
  # GET /page_elements/new.json
  def new
    @page_element = PageElement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page_element }
    end
  end

  # GET /page_elements/1/edit
  def edit
    @page_element = PageElement.find(params[:id])
  end

  # POST /page_elements
  # POST /page_elements.json
  def create
    @page_element = PageElement.new(params[:page_element])

    respond_to do |format|
      if @page_element.save
        format.html { redirect_to @page_element, notice: 'Page element was successfully created.' }
        format.json { render json: @page_element, status: :created, location: @page_element }
      else
        format.html { render action: "new" }
        format.json { render json: @page_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /page_elements/1
  # PUT /page_elements/1.json
  def update
    @page_element = PageElement.find(params[:id])

    respond_to do |format|
      if @page_element.update_attributes(params[:page_element])
        format.html { redirect_to @page_element, notice: 'Page element was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_elements/1
  # DELETE /page_elements/1.json
  def destroy
    @page_element = PageElement.find(params[:id])
    @page_element.destroy

    respond_to do |format|
      format.html { redirect_to page_elements_url }
      format.json { head :no_content }
    end
  end
end
