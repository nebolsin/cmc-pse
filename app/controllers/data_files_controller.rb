class DataFilesController < ApplicationController
  before_filter :authenticate

  # GET /data_files
  # GET /data_files.xml
  def index
    @data_files = DataFile.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @data_files }
    end
  end

  # GET /data_files/1
  # GET /data_files/1.xml
  def show
    @data_file = DataFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @data_file }
    end
  end

  # GET /data_files/new
  # GET /data_files/new.xml
  def new
    @data_file = DataFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_file }
    end
  end

  # GET /data_files/1/edit
  def edit
    @data_file = DataFile.find(params[:id])
  end

  # POST /data_files
  # POST /data_files.xml
  def create
    @data_file = current_user.data_files.new(params[:data_file])

    respond_to do |format|
      if @data_file.save
        flash[:notice] = 'DataFile was successfully created.'
        format.html { redirect_to(@data_file) }
        format.xml  { render :xml => @data_file, :status => :created, :location => @data_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @data_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /data_files/1
  # PUT /data_files/1.xml
  def update
    @data_file = DataFile.find(params[:id])

    respond_to do |format|
      if @data_file.update_attributes(params[:data_file])
        flash[:notice] = 'DataFile was successfully updated.'
        format.html { redirect_to(@data_file) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /data_files/1
  # DELETE /data_files/1.xml
  def destroy
    @data_file = DataFile.find(params[:id])
    @data_file.destroy

    respond_to do |format|
      format.html { redirect_to(data_files_url) }
      format.xml  { head :ok }
    end
  end
end
