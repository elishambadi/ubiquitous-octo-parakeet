defmodule CounterWeb.CounterLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def handle_event("increment", _params, socket) do
    {:noreply, assign(socket, count: socket.assigns.count + 1)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Counter: <%= @count %></h1>
      <button class="btn" phx-click="increment">Increment</button>
    </div>
    """
  end
end
