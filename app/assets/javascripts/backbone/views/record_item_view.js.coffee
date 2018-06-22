RecordManagerApp.Views.RecordItemView = Backbone.View.extend

  template: JST["backbone/templates/record_item"]

  tagName: 'tr'

  initialize: ->
    this.listenTo(this.model, 'destroy', this.remove)

  events:
    'click .delete-record' : 'deleteRecord'
    'click .edit-record' : 'editRecord'
    'click .save-record' : 'saveRecord'
    'click .artist-record' : 'displayArtistGraph'

  render: ->
    @$el.html(@template(title: this.model.get('title'), artist: this.model.get('artist'), \
                        year: this.model.get('year'), condition: this.model.get('condition'), \
                        id: this.model.get('id')))
    this

  updateTask: (e) ->
    fieldId = e.target.getAttribute('id')
    if $("#"+fieldId).is(':checked')
      this.model.save({status: 'complete'})
      @$(".todo-item-display").addClass('complete')
    else
      this.model.save({status: 'new'})
      @$(".todo-item-display").removeClass('complete')

  deleteRecord: ->
    this.model.destroy()

  editRecord: ->
    @$('#edit-record-' + this.model.get('id')).removeClass('edit-record')
    @$('.record-item-display').hide()
    @showEditElements()


  saveRecord: ->
    @getEditedRecordsAndSave()
    @hideEditElements()
    @showRecordElements()

  getEditedRecordsAndSave: ->
    title = @$("#record-title-edit-" + this.model.get('id')).val()
    artist = @$("#record-artist-edit-" + this.model.get('id')).val()
    year = @$("#record-year-edit-" + this.model.get('id')).val()
    condition = @$("#record-condition-edit-" + this.model.get('id')).val()
    this.model.save({title: title, artist: artist, year: year, condition: condition})

  hideEditElements: ->
    @$('#edit-record-' + this.model.get('id')).removeClass('save-record')
    $('.record-edit').attr('type', 'hidden')
    @$('#record-condition-edit-' + this.model.get('id')).addClass('record-edit-condition-hide')

  showEditElements: ->
    @$('#edit-record-' + this.model.get('id')).html('Save')
    @$('#edit-record-' + this.model.get('id')).addClass('save-record')
    @$('#record-condition-edit-' + this.model.get('id')).removeClass('record-edit-condition-hide')
    @$('.record-edit').attr('type', 'text')
    @$("#record-title-edit-" + this.model.get('id')).val(this.model.get('title'))
    @$("#record-artist-edit-" + this.model.get('id')).val(this.model.get('artist'))
    @$("#record-year-edit-" + this.model.get('id')).val(this.model.get('year'))
    @$("#record-condition-edit-" + this.model.get('id')).val(this.model.get('condition'))


  showRecordElements: ->
    @$('#edit-record-' + this.model.get('id')).html('Edit')
    @$('#edit-record-' + this.model.get('id')).addClass('edit-record')
    $('.record-item-display').show()
    @$("#record-title-display-" + this.model.get('id')).html(this.model.get('title'))
    @$("#record-artist-display-" + this.model.get('id')).html(this.model.get('artist'))
    @$("#record-year-display-" + this.model.get('id')).html(this.model.get('year'))
    @$("#record-condition-display-" + this.model.get('id')).html(this.model.get('condition'))

  displayArtistGraph: ->
    thisView = this
    $.ajax
      url: '/records/artist_graph_data'
      data: {artist: this.model.get('artist')}
      success: (data) ->
        $('#display-artist-graph-modal').modal('show')
        $('#artist-graph-modal-title').html(thisView.model.get('artist'))
        $('#artist-graph-img').attr('src', data.image_url)

