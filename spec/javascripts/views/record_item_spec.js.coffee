describe 'RecordManagerApp.Views.RecordItemView', ->
  beforeEach ->
    record_model = new RecordManagerApp.Models.RecordModel({id: 1, title: 'test title', artist: 'test artist', year: 1999, condition: 'Excellent'})
    record_model.url = '/record/1'
    @view = new RecordManagerApp.Views.RecordItemView(model: record_model)

  describe 'adds the record', ->
    it 'adds to the table', ->
      @view.render()
      expect(@view.$el.find('#record-title-display-1').html()).toContain('test title')

  describe 'deletes the record', ->
    it 'removes the record from the table', ->
      @view.render()
      server = sinon.fakeServer.create()
      @view.$el.find('.delete-record').trigger('click')
      expect(server.requests[0].method).toEqual('DELETE')
