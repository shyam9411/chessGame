defmodule ChessWeb.PageView do
  use ChessWeb, :view
  # use Phoenix.HTML

  """
  Attribution: The code to load images was taken from Piazza post: https://piazza.com/class/k03dspgc6oo42p?cid=168
  """
  def image_paths(conn) do
    # paths = Enum.flat_map ["b", "w"], fn color ->
    #    Enum.map ["Rook", "King", "Queen", "Bishop", "Knight"], fn type ->
    #      piece = "#{color}#{type}"
    #      {piece, Routes.static_path(conn, "/images/#{piece}.png")} 
    #    end
    # end

    # # paths
    # # |> Phoenix.HTML.raw()
    # paths
    # |> Phoenix.HTML.raw()
  end
end
