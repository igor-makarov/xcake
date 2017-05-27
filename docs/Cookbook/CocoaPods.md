# CocoaPods
[CocoaPods](https://github.com/CocoaPods/CocoaPods) is a common dependency manager for iOS. To automatically integrate CocoaPods into your Xcake-generated project, all you really need to do is add an `after_save` hook that runs CocoaPods.

```ruby
project.after_save do
    system "pod install"
end
```

Note that Ruby has several ways to run shell commands. It's recommended to use a method like `system` that shows the command's output while it's running so you know what's happening. See [this StackOverflow answer](https://stackoverflow.com/a/37329716/2855742) for guidance on choosing a method for running a shell command.
