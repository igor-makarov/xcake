#Hooks

Xcake allows you to run actions for certain events using Hooks. At the moment
there is only one hook supported "after_save" which is called after a project is
saved to disk. Here is an example where we run CocoaPods once a project has been
generated:

```ruby
Project.new do |c|
  after_save do
   `pod install`
  end
end
```
