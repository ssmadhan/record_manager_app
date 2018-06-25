RecordManagerApp.Views.NoRecordsView = Backbone.View.extend
  template: JST["backbone/templates/no_records"]

  render: ->
    @$el.html(@template())
    this