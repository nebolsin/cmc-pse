class SimulationsController < ApplicationController
  def update_status
    @simulation = Simulation.find(params[:id])
    @simulation.update_status
    redirect_to @simulation
  end

  def cancel
    @simulation = Simulation.find(params[:id])
    @simulation.cancel!
    redirect_to queue_computer_path(@simulation.computer)
  end

  def retrieve_result
    @simulation = Simulation.find(params[:id])
    @simulation.retrieve_result
    
    redirect_to @simulation
  end

  def index
    @simulations = Simulation.find(:all)
  end

  def show
    @simulation = Simulation.find(params[:id])
  end
end