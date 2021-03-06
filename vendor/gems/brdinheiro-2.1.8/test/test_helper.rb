require 'test/unit'
require File.dirname(__FILE__) + '/../lib/brdinheiro'


def tornar_metodos_publicos(clazz)
  clazz.class_eval do
    private_instance_methods.each { |instance_method| public instance_method }
    private_methods.each { |method| public_class_method method } 
  end  
end

def p80 text
  p '*'*80
  p text
  p '*'*80
end

class Test::Unit::TestCase
  def assert_false(boolean, message=nil)
    _wrap_assertion do
      assert_block("assert should not be called with a block.") { !block_given? }
      assert_block(build_message(message, "<?> is not false.", boolean)) { !boolean }
    end
  end
end