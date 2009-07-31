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
    it { should belong_to(:gallery) }
  end

  #
  # Validations
  #

  describe 'validations' do
    it { should validate_presence_of(:gallery_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:comment) }
    describe 'allows legitimate emails:' do
      ['foo@bar.com', 'foo@newskool-tld.museum', 'foo@twoletter-tld.de', 'foo@nonexistant-tld.qq',
       'r@a.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail.com',
       'hello.-_there@funnychar.com', 'uucp%addr@gmail.com', 'hello+routing-str@gmail.com',
       'domain@can.haz.many.sub.doma.in',
      ].each do |email_str|
        it "'#{email_str}'" do
          doing {
            @comment.email = email_str
            @comment.save.should be_true
            @comment.errors.on(:email).should be_nil
          }.should change(Comment, :count).by(1)
        end
      end
    end
    describe 'disallows illegitimate emails' do
      ['!!@nobadchars.com', 'foo@no-rep-dots..com', 'foo@badtld.xxx', 'foo@toolongtld.abcdefg',
       'Iñtërnâtiônàlizætiøn@hasnt.happened.to.email', 'need.domain.and.tld@de', "tab\t", "newline\n", 'r@.wk',
       # these are technically allowed but not seen in practice:
       'uucp!addr@gmail.com', 'semicolon;@gmail.com', 'quote"@gmail.com', 'tick\'@gmail.com', 'backtick`@gmail.com', 'space @gmail.com', 'bracket<@gmail.com', 'bracket>@gmail.com'
      ].each do |email_str|
        it "'#{email_str}'" do
          doing {
            @comment.email = email_str
            @comment.save.should be_false
            @comment.errors.on(:email).should_not be_nil
          }.should_not change(Comment, :count)
        end
      end
    end
    describe 'allows legitimate websites' do
      ['http://bar.com', 'http://newskool-tld.museum', 'http://bit.ly', 'http://twoletter-tld.de', 'http://nonexistant-tld.qq',
       'https://gmail.com', 'https://funnychar.com','http://can.haz.many.sub.doma.in',
      ].each do |website_str|
        it "'#{website_str}'" do
          doing {
            @comment.website = website_str
            @comment.save.should be_true
            @comment.errors.on(:website).should be_nil
          }.should change(Comment, :count).by(1)
        end
      end
    end
    describe 'disallows illegitimate websites' do
      ['http://@nobadchars.com', 'http://no-rep-dots..com', 'http://toolongtld.abcdefg',
       'http://Iñtërnâtiônàlizætiøn@hasnt.com', 'need.domain.de', "http://tab\t", "http://newline\n", 'http://.wk',
      ].each do |website_str|
        it "'#{website_str}'" do
          doing {
            @comment.website = website_str
            @comment.save.should be_false
            @comment.errors.on(:website).should_not be_nil
          }.should_not change(Comment, :count)
        end
      end
    end
  end

end
