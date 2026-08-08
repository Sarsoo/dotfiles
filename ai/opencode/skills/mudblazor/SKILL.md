---
name: mudblazor
description: "Use when writing or reviewing MudBlazor Blazor/Razor UI. Correct component idioms, server-side tables, forms, providers, pre-submit checklist."
---

# MudBlazor (Carnitas.Web)

Carnitas.Web is Blazor Server (.NET 10) using **MudBlazor** — a Material Design
component library written entirely in C#. **Component attributes are typed C# enum
parameters, not HTML/CSS strings.** This skill is the component-layer companion to the
Blazor fundamentals; if you're unsure about Razor itself, those rules still apply.

## Setup (already done in Carnitas.Web — verify, don't redo)

- `@using MudBlazor` in `_Imports.razor`; package `MudBlazor`; `AddMudServices()` in Program.cs.
- **Four providers in MainLayout.razor** (or per interactive page if per-page render mode):
  `<MudThemeProvider />`, `<MudPopoverProvider />`, `<MudDialogProvider />`, `<MudSnackbarProvider />`.
- Missing provider symptoms: components don't respond to clicks, or logged `Missing <MudPopoverProvider />`.
- Exactly ONE `MudThemeProvider` per app. Never add Bootstrap classes — Mud has components for that.

## The core rules

1. **Styling is enum-typed:** `Variant="Variant.Outlined"`, `Color="Color.Primary"`,
   `Typo="Typo.h6"`, `Size="Size.Medium"` — never `class="btn btn-primary"` or hex colors.
2. **Write this, not that:**
   | Wrong instinct                   | Correct MudBlazor                                                                         |
   | -------------------------------- | ----------------------------------------------------------------------------------------- |
   | `<input class="form-control" />` | `<MudTextField @bind-Value="x" Variant="Variant.Outlined" Label="…" />`                   |
   | `<select>` + `<option>`          | `<MudSelect @bind-Value="x" T="T"><MudSelectItem Value="…">…</MudSelectItem></MudSelect>` |
   | `<table><tr><td>` hand-rolled    | `<MudTable>` (logic) or `<MudSimpleTable>` (plain markup)                                 |
   | `<button class="btn">`           | `<MudButton Variant="Variant.Filled" Color="Color.Primary" OnClick="Handler">`            |
   | inline `<svg>` icons             | `Icon="@Icons.Material.Filled.Search"` (on MudIcon/MudIconButton/etc.)                    |
   | `class="container"` / grid divs  | `<MudContainer MaxWidth="MaxWidth.Medium">` / `<MudGrid>`+`<MudItem>`                     |
   | toast/alert divs                 | `@inject ISnackbar Snackbar` + `Snackbar.Add("msg", Severity.Success)`                    |
   | modal div + JS                   | `IDialogService.ShowAsync<MyDialog>(…)` + `<MudDialog>` root                              |
   | navbar `<ul>`                    | `<MudNavMenu>` → `<MudNavLink Href="/x" Match="NavLinkMatch.Prefix">`                     |
   | bootstrap `d-flex` etc.          | `<MudStack>`, `<MudSpacer>`, or Mud utility classes (`Class="mt-4"`)                      |
3. **Binding:** `@bind-Value` (two-way) or `Value` + `ValueChanged` + `ValueExpression`.
   `Format="yyyy/MM/dd"` for dates. Never `value="..."` + `onchange="..."`.
4. **Events:** `OnClick="Method"` (method group, no parens) or `OnClick="@(e => Handler(item.Id))"`.
   Handlers are `async Task`, never `async void`.
5. **No `<script>` in components.** No inline SVG. No `MarkupString` for user input.

## Tables — pick the right mode (Carnitas tables are server-side)

- **Server-side** (data comes from the Carnitas REST API / EF Core — default choice):
  ```razor
  <MudTable ServerData="ServerReload" T="MyModel" Dense="true" Hover="true" @ref="_table">
    <HeaderContent>
      <MudTh><MudTableSortLabel SortLabel="name" T="MyModel">Name</MudTableSortLabel></MudTh>
    </HeaderContent>
    <RowTemplate>
      <MudTd DataLabel="Name">@context.Name</MudTd>
    </RowTemplate>
    <PagerContent><MudTablePager /></PagerContent>
  </MudTable>
  @code {
      private MudTable<MyModel> _table = default!;
      private async Task<TableData<MyModel>> ServerReload(TableState state, CancellationToken token)
      {
          // forward token to HttpClient/EF calls
          var page = await _api.GetPageAsync(state.Page, state.PageSize,
                                             state.SortLabel, state.SortDirection, token);
          return new TableData<MyModel> { TotalItems = page.Total, Items = page.Items };
      }
      // after external changes: await _table.ReloadServerData();
  }
  ```
  - `ServerData` XOR `Items` — never both. Do NOT set `Filter` when using `ServerData`.
  - Sort: `state.SortLabel` + `state.SortDirection`; paging: `Skip(state.Page * state.PageSize).Take(state.PageSize)`.
- **Client-side** (small fully-loaded data): `Items="@Elements"` + `Filter="@(e => FilterFunc(e, _search))"`.
- `MultiSelection="true"` + `@bind-SelectedItems` for checkboxes; `FixedHeader="true"` + `Height="…"` for sticky headers.
- **`record` types break multi-select/edit** — provide a custom `IEqualityComparer<T>` via `Comparer=`.
- `RowsPerPage` must be in `PageSizeOptions` or users can't return to it.
- Advanced filtering/editing/grouping → `MudDataGrid`, not MudTable.

## Forms — pick one route, never both

- **MudForm route:** `<MudForm @ref="_form">` + `Validation="@(v => Validate(v))"` on inputs.
  Buttons must NOT use `ButtonType.Submit`; call `_form.Validate()` in the handler.
- **EditForm route:** `<EditForm>` + `<DataAnnotationsValidator />` + button
  `ButtonType="ButtonType.Submit"`. (Carnitas.Model models use data annotations.)
  Forgetting `DataAnnotationsValidator` silently disables validation.
- `OnlyValidateIfDirty="true"` skips untouched fields; `ReadOnly`/`Disabled` on MudForm cascades.

## Dialogs

- Open: `@inject IDialogService DialogService`;
  `var dlg = await DialogService.ShowAsync<MyDialog>("Title", options);`
  pass data via `DialogParameters<MyDialog>`; await `DialogResult`.
- Dialog component root: `<MudDialog>`; close via `MudDialogInstance.Close(DialogResult.Ok(value))`
  or `DialogResult.Cancel()` (Escape returns Cancel when `CloseOnEscapeKey` enabled).

## Pre-submit checklist (MudBlazor)

1. `@using MudBlazor` present; provider exists for dialog/snackbar/popover usage in the interactive render tree.
2. Table: `Items` XOR `ServerData`; `RowTemplate` uses `@context`; server path returns `TableData<T>` with `TotalItems`.
3. Form: MudForm or EditForm — not both; `DataAnnotationsValidator` inside EditForm; correct button type.
4. Styling via enums; no Bootstrap classes, inline SVG, `<script>`, or hardcoded hex colors.
5. `@bind-Value` for inputs; `Format` for dates; method-group event handlers; `async Task` only.
6. No `MarkupString` for user input; no mixing raw HTML where a Mud component exists.

## Notes

- mudblazor.com is a WASM SPA — can't be scraped with curl. The docs' source of truth
  is the MudBlazor repo: `src/MudBlazor.Docs/Pages/{Components,Getting Started,…}/…Page.razor`
  (API surface) + `Examples/*.razor` beside them (ground-truth snippets).
- Deeper context: see the wiki page at `/mnt/notes/concepts/mudblazor-guide.md`.
