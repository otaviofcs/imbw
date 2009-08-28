require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Note do
  fixtures :notes

  before(:each) do
    @valid_attributes = {
      :note => 'uma nota',
      :note_taked_at => Time.current,
      :twit_id => 19
    }
    @note = Note.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @note.save.should be_true
  end

  describe "validations" do
    it{ should validate_presence_of(:twit_id) }
    it{ should validate_uniqueness_of(:twit_id) }
    it{ should validate_presence_of(:note_taked_at) }
    it{ should validate_presence_of(:note) }
    it "should not allow beer votes as note" do
      @note.note = "#beer %bv 3 %bd ótima"
      doing { @note.save! }.should raise_error
      @note.note = "#beer %title Erdinger %bd ótima"
      doing { @note.save! }.should raise_error
      @note.note = "#beer essa %aqui passa, %sem problema"
      doing { @note.save! }.should_not raise_error
    end
  end
end
