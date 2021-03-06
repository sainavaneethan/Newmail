class NotesController < ApplicationController
  # GET /notes
  # GET /notes.xml
  def index
    @notes = Note.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])    
    @note.client_id  = @client.id
    @note.user_id  = @current_user["id"]
    respond_to do |format|
      if @note.save
        if request.xhr?
          format.html {render :partial => "notes/note"}
        else
          flash[:notice] = 'Note was successfully created.'
          format.html { redirect_to(@note) }
          format.xml  { render :xml => @note, :status => :created, :location => @note }
        end
      else
        if request.xhr?
          format.html{ render :text => @note.errors.instance_variable_get("@errors").collect{|k, v| "#{k} : #{v}"}.join("<br/>"), :status => 500}
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        flash[:notice] = 'Note was successfully updated.'
        format.html { redirect_to(@note) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to(notes_url) }
      format.xml  { head :ok }
    end
  end
end
