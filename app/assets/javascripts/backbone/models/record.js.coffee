RecordManagerApp.Models.RecordModel = Backbone.Model.extend
  defaults: ->
    return {title: '', artist: '', year: 1970, condition: ''}

RecordManagerApp.Collections.RecordCollection = Backbone.Collection.extend
  url: '/records'
  model: RecordManagerApp.Models.RecordModel

