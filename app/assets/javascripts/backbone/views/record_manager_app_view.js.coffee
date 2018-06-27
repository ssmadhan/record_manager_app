RecordManagerApp.Views.RecordManagerAppView = Backbone.View.extend
  template: JST["backbone/templates/record_manager_app_main"]


  initialize: ->
    _.bindAll(this, 'fetchRecords')
    @record_collection = new RecordManagerApp.Collections.RecordCollection()
    @no_records_view = new RecordManagerApp.Views.NoRecordsView()
    @sort_by = "title:ASC"
    this.listenTo(@record_collection, 'add', this.addOne)
    this.listenTo(@record_collection, 'change', this.addOne)

  events:
    'click #add-new-record' : 'addNewRecord'
    'click #create-new-record' : 'createNewRecord'
    'click .sortable-column'  : 'setSortOrderAndFetch'

  render: ->
    @$el.html(@template())
    @fetchRecords()
    this

  setSortOrderAndFetch: (e) ->
    fieldId = e.target.getAttribute("id")
    current_sort_field = @sort_by.split(':')[0]
    current_sort_order = @sort_by.split(':')[1]
    if fieldId == current_sort_field
      if current_sort_order == 'ASC'
        @sort_by = fieldId + ':DESC'
      else
        @sort_by = fieldId + ':ASC'
    else
      @sort_by = fieldId + ':ASC'
    @fetchRecords()


  fetchRecords: () ->
    @record_collection.reset()
    @$("#records-table-body").empty()
    thisView = this
    @record_collection.fetch(
      data: {sort_by: @sort_by}
      success: (data) ->
        if data.length == 0
          $("#records-table-body").append(thisView.no_records_view.render().el)
    )

  addNewRecord: ->
    @$('#record-success-alert').hide()
    @$('#record-error-alert').hide()
    @$('#add-new-record-modal').modal('show')

  addOne: (record) ->
    if record.get('id')
      @no_records_view.remove()
      @$('#new-record-form')[0].reset()
      view = new RecordManagerApp.Views.RecordItemView(model: record)
      @$("#records-table-body").append(view.render().el)

  createNewRecord: ->
    title = @$('#album-title').val()
    artist = @$('#artist-name').val()
    year = @$('#record-year').val()
    condition = @$('#record-condition').val()
    @record_collection.create(
      {title: title, artist: artist, year: year, condition: condition},
      {
        success: ->
          @$('#record-success-alert').show()
          @$('#record-error-alert').hide()
        error: (status, response) ->
          @$('#record-success-alert').hide()
          @$('#record-error-alert').show()
          response_json = JSON.parse(response.responseText)
          error_string = ''
          for key,value of response_json
            error_string = key + ' '
            error_messages = value
            first = true
            for emsg in error_messages
              if not first
                error_string = error_string + ' ,'
              error_string = error_string + emsg
              first = false
            $('#record-error-msg').append(error_string)
      }
    )
