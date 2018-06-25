describe 'RecordManagerApp.Views.RecordManagerAppView', ->
  beforeEach ->
    @view = new RecordManagerApp.Views.RecordManagerAppView()
    @server = sinon.fakeServer.create()

  afterEach ->
      @server.restore()

  describe 'renders correctly', ->
    it 'has the right html content', ->
      @view.render()
      expect(@view.$el.find('#add-new-record').html()).toEqual('Add Record')

    it 'it fetches and renders records on render', ->
      server = sinon.fakeServer.create()
      server.respondWith("GET", "/records?sort_by=title%3AASC", [200, { "Content-Type": "application/json" },
                          '[{ "id": "1", "title": "test-title", "artist": "test-artist", "year": 1999, "condition": "Poor" }]'])
      @view.render()
      server.respond()
      expect(@view.$el.find('#records-table-body').html()).toContain('test-title')
      server.restore()

  describe 'adds a record', ->
    it 'adds the record to the table', ->
      @view.render()
      @view.$el.find('#album-title').val('test-title')
      @view.$el.find('#artist-name').val('test-name')
      @view.$el.find('#record-year').val(2000)
      @view.$el.find('#record-condition').val('Excellent')
      @view.$el.find('#create-new-record').trigger('click')
      expect(@view.$el.find('#records-table-body').html()).toContain('test-title')
