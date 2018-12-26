require 'spec_helper'

class Parent
  Class.send(:include, Xcake::CoreExtensions::ClassDescendants) # done with send because of old ruby versions
end

class Child < Parent
end

class Grandchild < Child
end

describe Xcake::CoreExtensions do
  it 'should return all descendants' do
    descendants = Parent.descendants

    expect(descendants.count).to eq(2)
    expect(descendants).to include(Child)
    expect(descendants).to include(Grandchild)
  end
end
