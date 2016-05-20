defmodule Trans.QueryBuilder do
  import Ecto.Query, only: [from: 2]

  # TODO add documentation
  def with_translations(query, locale, opts \\ [])

  def with_translations(query, locale, opts) when is_atom(locale) do
    with_translations(query, to_string(locale), opts)
  end

  def with_translations(query, locale, opts) when is_binary(locale) do
    translations_container = opts[:container] || :translations
    from translatable in query,
      where: fragment("(?->>?) is not null", field(translatable, ^translations_container), ^locale)
  end

end
