defmodule TexWeb.Components.Pagination do
  use Phoenix.Component

  attr :page, :map, required: true
  attr :path, :any
  def pagination(assigns) do
    ~H"""
    <div class="inline-flex items-center justify-center gap-3">
      <a :if={@page.page_number > 1}
        href={@path.(@page.page_number - 1)}
        class="inline-flex h-8 w-8 items-center justify-center rounded border border-gray-100 bg-white text-gray-900 rtl:rotate-180"
      >
        <span class="sr-only">Next Page</span>
        <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" viewBox="0 0 20 20" fill="currentColor">
          <path
            fill-rule="evenodd"
            d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
            clip-rule="evenodd"
          />
        </svg>
      </a>

      <p class="text-xs text-gray-900">
        <%= @page.page_number %>
        <span class="mx-0.25">/</span>
        <%= @page.total_pages %>
      </p>

      <a :if={@page.page_number < @page.total_pages}
        href={@path.(@page.page_number + 1)}
        class="inline-flex h-8 w-8 items-center justify-center rounded border border-gray-100 bg-white text-gray-900 rtl:rotate-180"
      >
        <span class="sr-only">Next Page</span>
        <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" viewBox="0 0 20 20" fill="currentColor" >
          <path
            fill-rule="evenodd"
            d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
            clip-rule="evenodd"
          />
        </svg>
      </a>
    </div>
    """
  end
end