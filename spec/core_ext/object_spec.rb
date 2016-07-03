require 'spec_helper'

class Parent
end

class Child < Parent
end

class Grandchild < Child
end

describe Object do
  it 'should return all descendants' do
    descendants = Parent.descendants

    expect(descendants).to include(Child)
    expect(descendants).to include(Grandchild)
  end
end
