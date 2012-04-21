
require 'gtk2'

button = Gtk::Button.new("Hello World!")
button.signal_connect("clicked"){ | w |
# puts w.inspect
  puts "Hello world"
}

button.signal_connect("button_press_event") do  | w, e|
  puts e.x
puts w.inspect
end

window = Gtk::Window.new

window.signal_connect("delete_event"){
  puts "delete event occured"
  #true
  false
}


window.signal_connect("destroy"){
  puts "destroy event occured"
  Gtk.main_quit
}

window.border_width = 10
window.add(button)
window.show_all

Gtk.main
