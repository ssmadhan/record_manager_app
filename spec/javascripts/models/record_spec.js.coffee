describe 'RecordManagerApp.Models.RecordModel', ->
  beforeEach ->
    @record = new RecordManagerApp.Models.RecordModel()

  it "can be instantiated", ->
    expect(@record).not.toBeNull()

  describe 'has default values', ->
    it 'has default value for title attribute', ->
      expect(@record.get('title')).toEqual('')
    it 'has default value for artist attribute', ->
      expect(@record.get('artist')).toEqual('')
    it 'has default value for year attribute', ->
      expect(@record.get('year')).toEqual(1970)
    it 'has default value for condition attribute', ->
      expect(@record.get('condition')).toEqual('')

