defmodule Changelog.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Changelog.Web, :controller
      use Changelog.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema
      use Timex.Ecto.Timestamps
      alias Changelog.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Changelog.Repo
      alias Changelog.Plug.{RequireAdmin, RequireUser, RequireGuest}
      import Ecto
      import Ecto.Query

      import Changelog.Router.Helpers
      import Changelog.Plug.Conn
    end
  end

  def admin_view do
    quote do
      use Phoenix.View, root: "web/templates"
      use Phoenix.HTML
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 1,get_flash: 2, view_module: 1]
      import Scrivener.HTML
      import Changelog.Router.Helpers
      import Changelog.Helpers.SharedHelpers
      import Changelog.Helpers.AdminHelpers
      alias Changelog.TimeView
    end
  end

  def public_view do
    quote do
      use Phoenix.View, root: "web/templates"
      use Phoenix.HTML
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 1,get_flash: 2, view_module: 1]
      import Changelog.Router.Helpers
      import Changelog.Helpers.SharedHelpers
      import Changelog.Helpers.PublicHelpers
      alias Changelog.TimeView
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Changelog.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
