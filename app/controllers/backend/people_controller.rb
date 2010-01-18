class Backend::PeopleController < BackendController

  def index
    params[:limit] ||= 50
    
    @column_store = column_store_for Person do |cm|
      cm.add :first_name
      cm.add :middle_name
      cm.add :last_name
      cm.add :nick_name
      cm.add :gender
      cm.add :birth_date, :renderer => :date 
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
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      redirect_parent_to(:action => "edit", :id => @person)
    else
      render_to_parent(:action => "new")
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id]) 
    
    if @person.update_attributes(params[:person])
      respond_to do |format|
        format.html { redirect_parent_to(:action => "edit", :id => @person) }
        format.json { render :json => { :success => true } }
      end
    else
      respond_to do |format|
        format.html { render_to_parent(:action => "edit") }
        format.json { render :json => { :success => false, :msg => @person.errors.full_messages.join("<br />") } }
      end
    end
  end
  
  # Add in your model before_destroy and if the callback returns false, 
  # all the later callbacks and the associated action are cancelled.
  def destroy
    if Person.find(params[:id]).destroy
      render :json => { :success => true } 
    else
      render :json => { :success => false, :msg => I18n.t("backend.general.cantDelete") }
    end
  end
end