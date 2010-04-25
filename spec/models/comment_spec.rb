require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  fixtures :galleries

  before(:each) do
    @valid_attributes = {
      :name => 'astolfo',
      :comment => 'meu commentário é, ...'
    }
    @comment = galleries(:one).comments.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @comment.save.should be_true
  end


  describe 'associations' do
    it { should have_one(:recent_activity, :as => :recentable, :dependent => :destroy) }
  end

  #
  # Validations
  #

  describe 'validations' do
    it { should validate_presence_of(:commentable_type) }
    it { should validate_presence_of(:commentable_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:comment) }
    it { should allow_values_for(:email, 'foo@bar.com', 'foo@newskool-tld.museum', 'foo@twoletter-tld.de', 'foo@nonexistant-tld.qq',
       'r@a.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail.com',
       'hello.-_there@funnychar.com', 'uucp%addr@gmail.com', 'hello+routing-str@gmail.com',
       'domain@can.haz.many.sub.doma.in') }
    it { should_not allow_values_for(:email, '!!@nobadchars.com', 'foo@no-rep-dots..com', 'foo@badtld.xxx', 'foo@toolongtld.abcdefg',
       'Iñtërnâtiônàlizætiøn@hasnt.happened.to.email', 'need.domain.and.tld@de', "tab\t", "newline\n", 'r@.wk',
       'uucp!addr@gmail.com', 'semicolon;@gmail.com', 'quote"@gmail.com', 'tick\'@gmail.com', 'backtick`@gmail.com', 'space @gmail.com', 'bracket<@gmail.com', 'bracket>@gmail.com'
     ) }
    it { should allow_values_for(:website, 'http://bar.com', 'http://newskool-tld.museum', 'http://bit.ly', 'http://twoletter-tld.de', 'http://nonexistant-tld.qq', 'https://gmail.com', 'https://funnychar.com','http://can.haz.many.sub.doma.in') }
    it { should_not allow_values_for(:website, 'http://@nobadchars.com', 'http://no-rep-dots..com', 'http://toolongtld.abcdefg','http://Iñtërnâtiônàlizætiøn@hasnt.com', 'need.domain.de', "http://tab\t", "http://newline\n", 'http://.wk') }
  end

end
