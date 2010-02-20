class Backend::EventsController < BackendController

  def index
    params[:limit] ||= 50
    
    @column_store = column_store_for Event do |cm|
      cm.add :name
      cm.add :properties
      cm.add :date, :renderer => :date 
      cm.add :created_at, :renderer => :datetime 
      cm.add :updated_at, :renderer => :datetime 
    end
    
    respond_to do |format|
      format.js 
      format.json do
        render :json => @column_store.store_data(params)
      end
    end
  end

  
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_parent_to(:action => "edit", :id => @event)
    else
      render_to_parent(:action => "new")
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id]) 
    
    if @event.update_attributes(params[:event])
      respond_to do |format|
        format.html { redirect_parent_to(:action => "edit", :id => @event) }
        format.json { render :json => { :success => true } }
      end
    else
      respond_to do |format|
        format.html { render_to_parent(:action => "edit") }
        format.json { render :json => { :success => false, :msg => @event.errors.full_messages.join("<br />") } }
      end
    end
  end
  
  # Add in your model before_destroy and if the callback returns false, 
  # all the later callbacks and the associated action are cancelled.
  def destroy
    if Event.find(params[:id]).destroy
      render :json => { :success => true } 
    else
      render :json => { :success => false, :msg => I18n.t("backend.general.cantDelete") }
    end
  end
end