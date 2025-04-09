defmodule CounterWeb.TodoLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    todos = []
    {:ok, assign(socket, todos: todos, new_todo: "")}
  end

  def handle_event("add_todo", %{"todo" => todo}, socket) do
    todos = socket.assigns.todos
    updated_todos = [todo | todos]
    {:noreply, assign(socket, todos: updated_todos, new_todo: "")}
  end

  def handle_event("delete_todo", %{"index" => index}, socket) do
    todos = socket.assigns.todos
    updated_todos = List.delete_at(todos, String.to_integer(index))
    {:noreply, assign(socket, todos: updated_todos)}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-xl mx-auto p-6 bg-white rounded-lg shadow-lg">
      <h1 class="text-2xl font-semibold text-center">To-Do List</h1>

      <form phx-submit="add_todo" class="mt-4">
        <input
          type="text"
          name="todo"
          placeholder="New task..."
          value=""
          class="w-full px-4 py-2 rounded border border-gray-300"
        />
        <button type="submit" class="mt-2 w-full bg-blue-500 text-white py-2 rounded">
          Add Task
        </button>
      </form>

      <ul class="mt-6">
        <%= for {todo, index} <- Enum.with_index(@todos) do %>
          <li class="flex justify-between items-center py-2 border-b">
            <span><%= todo %></span>
            <button
              phx-click="delete_todo"
              phx-value-index="{index}"
              class="text-red-500"
            >
              Delete
            </button>
          </li>
        <% end %>
      </ul>
    </div>
    """
  end
end
