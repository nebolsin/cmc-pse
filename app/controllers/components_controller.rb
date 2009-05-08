class ComponentsController < ApplicationController
  before_filter :authenticate

  def install
    @component = Component.find(params[:id])
    @computer = Computer.find(params[:component][:computer_ids])

    @computer.install_component(@component)

    @component.computers << @computer

    redirect_to @component
  end

  def uninstall
    @component = Component.find(params[:id])
    @computer = Computer.find(params[:computer_id])

    @computer.uninstall_component(@component)
    
    @component.computers.delete @computer

    redirect_to @component
  end

  def simulate
    @component = Component.find(params[:id])
    @computer = Computer.find(params[:computer_id])

    @simulation = Simulation.new
    @simulation.component = @component
    @simulation.computer = @computer
    @simulation.user = current_user
    @simulation.save

    @computer.simulate(@simulation)

    @simulation.update_status

    redirect_to @component
  end

  # GET /components
  # GET /components.xml
  def index
    @components = Component.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @components }
    end
  end

  # GET /components/1
  # GET /components/1.xml
  def show
    @component = Component.find(params[:id])
    @available_computers = Computer.all.reject {|computer| @component.computers.include?(computer)}

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @component }
    end
  end

  # GET /components/new
  # GET /components/new.xml
  def new
    @component = Component.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @component }
    end
  end

  # GET /components/1/edit
  def edit
    @component = Component.find(params[:id])
  end

  # POST /components
  # POST /components.xml
  def create
    @component = current_user.components.new(params[:component])

    respond_to do |format|
      if @component.save
        flash[:notice] = 'Component was successfully created.'
        format.html { redirect_to(@component) }
        format.xml  { render :xml => @component, :status => :created, :location => @component }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @component.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /components/1
  # PUT /components/1.xml
  def update
    @component = Component.find(params[:id])

    respond_to do |format|
      if @component.update_attributes(params[:component])
        flash[:notice] = 'Component was successfully updated.'
        format.html { redirect_to(@component) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @component.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /components/1
  # DELETE /components/1.xml
  def destroy
    @component = Component.find(params[:id])
    @component.destroy

    respond_to do |format|
      format.html { redirect_to(components_url) }
      format.xml  { head :ok }
    end
  end
end
