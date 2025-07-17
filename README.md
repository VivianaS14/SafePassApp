## Active Record Encryption

First you need to run this command

```
bin/rails db:encryption:init
```

It should respond with something like this:

```
Add this entry to the credentials of the target environment:

active_record_encryption:
  primary_key: EGY8WhulUOXixybod7ZWwMIL68R9o5kC
  deterministic_key: aPA5XyALhf75NNnMzaspW7akTfZp0lPY
  key_derivation_salt: xEY0dt6TZcAMg52K7O84wYzkjvbA62Hz
```

Then you need to save those credentials with the following command:

```
EDITOR="code --wait" rails credentials:edit
```

Copy the credentials bellow and save it at the end of the file, then close it and in console you should see something like these

```
Configured Git diff driver for credentials.
Editing config/credentials.yml.enc...
File encrypted and saved.
```

In model you can encrypt data using these:

```
encrypts :username, deterministic: true
encrypts :password
```

Mode in docs: https://guides.rubyonrails.org/active_record_encryption.html

## Turbo Frame

Turbo Frames allow predefined parts of a page to be updated on request.

To use turbo frame you can wrap the content you want to update:

```erb
<!-- app/views/entries/index.html.erb -->
<%= turbo_frame_tag('main-dashboard') do %>
  <%= render(partial: 'entries/main', locals: {entry: @main_entry}) %>
<% end %>
```

Then each trigger action link should have as data the id gave it to the turbo frame:

```erb
<!-- app/views/entries/_entry.html.erb -->
<%= link_to(entry_path(entry), class: 'nav-link', data: {turbo_frame: 'main-dashboard'}) do %>
   ...
<% end %>
```

Finally, the view that should be render in the frame should be:

```erb
<!-- app/views/entries/show.html.erb -->
<%= turbo_frame_tag('main-dashboard') do %>
  ...
<% end %>
```

## Turbo Stream

Turbo Streams deliver page changes as fragments of HTML wrapped in <turbo-stream> elements. Each stream element specifies an action together with a target ID to declare what should happen to the HTML inside it.

They can be used to surgically update the DOM after a user action such as removing an element from a list without reloading the whole page, or to implement real-time capabilities such as appending a new message to a live conversation as it is sent by a remote user.

```erb
app/views/entries/index.html.erb

<%# We put as data the id for the part we wanna change with turbo stream, in this case "main-dashboard" %>
    <%= link_to('+ New Entry', new_entry_path, class: 'btn btn-primary', data: {turbo_frame: "main-dashboard"})%>

<div class="entries-card__main">
  <%# Envolvemos la sección que queremos modificar dentro de un turbo frame %>
  <%= turbo_frame_tag('main-dashboard') do %>
    <%= render(partial: 'entries/main', locals: {entry: @main_entry}) %>
  <% end %>
</div>
```

In the controller, we need to send the respond as turbo stream, in this case we use files as responses

```erb
if @entry.save
  flash.now[:notice] = "<strong>#{@entry.name}<strong> has saved!".html_safe
  # Tu use turbo stream we use a respond block
  respond_to do |format|
    format.html { redirect_to root_path }
    format.turbo_stream { }
  end
else
  render :new, status: :unprocessable_entity
end
```

Then create the file with the action name and ending with turbo_stream, because this is a turbo stream response

```erb
app/views/entries/create.turbo_stream.erb
```

## Stimulus

Add interactivity to your HTML without taking over the whole page like other big frameworks (e.g., React or Vue).

It’s often called a "modest JavaScript framework" because instead of replacing HTML, it works with your HTML.

https://stimulus.hotwired.dev/handbook/hello-stimulus

How does it works?
Stimulus uses controllers (JavaScript files) that are connected to your HTML via data-\* attributes

First you need to link the controller name into HTML piece you want to work with; and in the button we want to do the action you need to link data-action as "action->controller#function"

```erb
app/views/entries/index.html.erb
<div class="entry-search" data-controller="search">
...
  <div class="form-floating">
    <%= f.text_field(:name, placeholder: "Search", class: "form-control", data: { action: "input->search#toggleClearButton" }) %>
    <%= f.label(:search, for: :name) %>
  </div>
</div>
```

In this case we want to show or hide a button so we need a target to use in the JS function, we define data-target like this:

```erb
<%= link_to(root_path, class: "btn btn-sm btn-outline-danger rounded-circle p-0 lh-1 me-2 d-none", data: { search_target: "clearButton" }) do %>
  <i class="bi bi-x"></i>
<% end %>
```

JavaScript (Stimulus controller):

```js
// app/javascript/controllers/search_controller.js
import { Controller } from "@hotwired/stimulus";

class SearchController extends Controller {
  // We access to the button we want to toggle
  static targets = ["clearButton"];

  toggleClearButton(event) {
    if (event.target.value) {
      this.clearButtonTarget.classList.remove("d-none");
    } else {
      this.clearButtonTarget.classList.add("d-none");
    }
  }
}

export default SearchController;
```

### What's happening?

`data-controller="search"` connects the HTML to `search_controller.js`.

`data-action="input->search#toggleClearButton"` tells Stimulus:

“When someone type in this input, call the toggleClearButton() method in the search controller.”

### Concepts

| Concept        | Explanation                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| **Controller** | A JavaScript class connected to an HTML element.                                 |
| **Target**     | Specific child elements inside your controller’s HTML you want to interact with. |
| **Action**     | Tells Stimulus what method to call when an event (like click) happens.           |

### 🔍 Real-Life Use Cases

- Toggle menus or modals
- Tabs and dropdowns
- Dynamic form fields
- Show/hide sections
- Auto-submit on selection
