RecordManagerApp.Routers.RecordManagerAppRouter = Backbone.Router.extend

  routes:
    "home": "displayMainAppContent"

  initialize: ->

  displayMainAppContent: ->
    view = new RecordManagerApp.Views.RecordManagerAppView()
    $('#record-manager-main-container').html(view.render().el)