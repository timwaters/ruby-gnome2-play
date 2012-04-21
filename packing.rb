require 'gtk2'

# Make a new hbox filled with button-labels. Arguments for Gtk::HBox.new and 
# Gtk::Box#pack_start we are interested are passed in to this method.
def make_box(homogeneous, spacing, expand, fill, padding)
    box = Gtk::HBox.new(homogeneous, spacing)

    "Gtk::Box#pack_start (button, #{expand}, #{fill}, #{padding})".split(/ /).each do |s|
        button = Gtk::Button.new(s)
        box.pack_start(button, expand, fill, padding)
    end
    box
end

# Parse command line argument.
which = ARGV.shift
unless which
    $stderr.puts "usage: #{$0} num"
    $stderr.puts "	where num is 1, 2, or 3."
    exit 1
end

# Creates the main window.
window = Gtk::Window.new

# You should always remember to connect the delete_event signal
# to the main window. This is very important for proper intuitive
# behavior.
window.signal_connect("delete_event") do
    Gtk::main_quit
    false
end
window.border_width = 10

# We create a vertical box (vbox) to pack the horizontal boxes into (created by make_box).
# This allows us to stack the horizontal boxes filled with buttons one
# on top of the other in this vbox.
box1 = Gtk::VBox.new(false, 0)

case which.to_i
when 1
    # Creates and aligns a new label to the left side.  
    # We'll discuss this function and others in the section on Widget Attributes.
    label = Gtk::Label.new("Gtk::HBox.new(false, 0)")
    label.set_alignment(0, 0)
    box1.pack_start(label, false, false, 0)

    # The 2 first entries are for homegeneous and spacing parameters for Gtk::HBox.new.
    # The 3 last entries are for expand, fill and padding parameters for Gtk::HBox#pack_start.
    [
        [false, 0, false, false, 0],
        [false, 0, true,  false, 0],
        [false, 0, true,  true,  0],
    ].each do |args|
        # Create a horizontal box with the specified parameters 
        # and pack it on top of the vertical box.

        box2 = make_box(*args)
        box1.pack_start(box2, false, false, 0)
    end

    # Insert a separator in the vertical box.
    separator = Gtk::HSeparator.new
    box1.pack_start(separator, false, true, 5)

    # Same as previous.
    label = Gtk::Label.new("Gtk::HBox.new(true, 0)")
    label.set_alignment(0, 0)
    box1.pack_start(label, false, false, 0)
    [
        [true, 0, true, false, 0],
        [true, 0, true, true,  0],
    ].each do |args|
        box2 = make_box(*args)
        box1.pack_start(box2, false, false, 0)
    end

    separator = Gtk::HSeparator.new
    box1.pack_start(separator, false, true, 5)

when 2
    label = Gtk::Label.new("Gtk::HBox.new(false, 10)")
    label.set_alignment(0, 0)
    box1.pack_start(label, false, false, 0)

    [
        [false, 10, true, false, 0],
        [false, 10, true, true,  0],
    ].each do |args|
        box2 = make_box(*args)
        box1.pack_start(box2, false, false, 0)
    end

    separator = Gtk::HSeparator.new
    box1.pack_start(separator, false, true, 5)

    label = Gtk::Label.new("Gtk::HBox.new(false, 0)")
    label.set_alignment(0, 0)
    box1.pack_start(label, false, false, 0)

    [
        [false, 0, true, false, 10],
        [false, 0, true, true,  10],
    ].each do |args|
        box2 = make_box(*args)
        box1.pack_start(box2, false, false, 0)
    end

    separator = Gtk::HSeparator.new
    box1.pack_start(separator, false, true, 5)

when 3
    # This demonstrates the ability to use Gtk::Box#pack_end to
    # right justify widgets. First, we create a new box as before.
    box2 = make_box(false, 0, false, false, 0);

    # Create a label that will be put at the end.
    label = Gtk::Label.new("end")
    box2.pack_end(label, false, false, 0)
    box1.pack_start(box2, false, false, 0)

    # A separator for the bottom.
    separator = Gtk::HSeparator.new

    # This explicitly sets the separator to 400 pixels wide by 5 pixels
    # high. This is so the hbox we created will also be 400 pixels wide,
    # and the "end" label will be separated from the other labels in the
    # hbox. Otherwise, all the widgets in the hbox would be packed as
    # close together as possible. 
    separator.set_size_request(400, 5)
    box1.pack_start(separator, false, true, 5)
end

# Creates a new box, and packs a 'quit' button to it.
# This button can be used to terminate the program, exactly like the window
# close cross.
quitbox = Gtk::HBox.new(false, 0)
button = Gtk::Button.new("Quit")
button.signal_connect("clicked") do
    Gtk.main_quit
end 

quitbox.pack_start(button, true, false, 0)
box1.pack_start(quitbox, true, false, 0)
window.add(box1)

# Display all widgets.
window.show_all

# As usual, we finish by entering the main loop, with Gtk.main.
Gtk.main
