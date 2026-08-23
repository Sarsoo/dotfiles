---
name: csharp-blazor-conventions
description: >-
  Use when writing or reviewing C# UIs in Blazor/Razor. Guardrails against HTML/JS/React leaks: correct @onclick/@bind/[Parameter] idioms, no <script> in components, C# not JS in @code, pre-submit checklist.
---

# Blazor UI Conventions (for AI coding agents)

Guardrail for AI coding agents (OpenCode, Claude Code, Copilot) writing Razor/Blazor
components. Created 2026-08-08 after OpenCode produced HTML/JS-flavoured markup in
[[carnitas]]'s Carnitas.Web (Blazor Server, .NET 10). **If the code would be valid in
a static HTML page or a React/JSX component, it is probably WRONG in Blazor.**

## The core rule

Blazor markup is **C#, not HTML+JS**. Three things that are normal elsewhere are
errors here:

1. **No `<script>` tags in components.** JS runs only via JS Interop (`IJSRuntime`),
   loaded as an ES module from `wwwroot/`, and only when C# genuinely cannot do it
   (clipboard, file picker, canvas, charts, DOM measurements). JS DOM manipulation
   fights the render tree and desyncs Blazor Server's SignalR state.
2. **Event wiring is `@on<event>` with a C# method** — never an inline JS string.
3. **All dynamic values are `@expr`** and expressions are C# (types, `null`, LINQ) —
   not JS (`undefined`, `===`, template literals, `.map()`).

## Leak table — write this, not that

| HTML / JS / React instinct                               | Correct Blazor                                                                                             |
| -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `onclick="handler()"`                                    | `@onclick="Handler"` (method group, no parens) or `@onclick="() => Handler(item.Id)"`                      |
| `onchange` / `onChange`                                  | `@onchange="(ChangeEventArgs e) => ..."`                                                                   |
| `<script>...</script>`                                   | Don't. Interop module via `IJSRuntime`, called from `OnAfterRenderAsync(firstRender: true)` or user events |
| `document.getElementById("x").value`                     | `@bind="field"`, or `@ref` + `ElementReference`                                                            |
| `value={x} onChange={e => setX(...)}` (React controlled) | `@bind="x"`; `@bind-value:event="oninput"` for live updates                                                |
| `className` (React)                                      | `class`; dynamic: `class="@(cond ? "a" : "b")"`                                                            |
| `style={{...}}` (React object)                           | `style="..."` string or `style="@(cond ? "a" : "b")"`                                                      |
| `{expr}` JSX braces                                      | `@expr`                                                                                                    |
| `${template}` literals                                   | `@($"Count: {count}")` or a C# string property                                                             |
| `.map(x => <li>{x}</li>)`                                | `@foreach (var x in xs) { <li>@x</li> }`                                                                   |
| `key={item.id}`                                          | `@key="item.Id"`                                                                                           |
| `{cond && <div/>}`                                       | `@if (cond) { <div/> }`                                                                                    |
| `useState`                                               | plain C# field/property; re-render via events or `StateHasChanged()`                                       |
| `useEffect`                                              | lifecycle: `OnInitializedAsync`, `OnParametersSetAsync`, `OnAfterRenderAsync`                              |
| `props`                                                  | `[Parameter] public string Title { get; set; }`                                                            |
| `children`                                               | `ChildContent` (`RenderFragment`)                                                                          |
| `useContext` / global store                              | `@inject IService` (DI) or `[CascadingParameter]`                                                          |
| `fetch('/api/x')`                                        | `@inject HttpClient` + `GetFromJsonAsync<T>()`                                                             |
| `addEventListener`                                       | `@onmouseenter`, `@onkeydown`, ... (Razor events)                                                          |
| `dangerouslySetInnerHTML`                                | `@((MarkupString)html)` — XSS risk, same as React; avoid/sanitise                                          |
| `window.location.href`                                   | `@inject NavigationManager` + `NavigateTo(...)`                                                            |
| `setTimeout(fn, 1000)`                                   | `await Task.Delay(1000)` + `StateHasChanged()`                                                             |
| `JSON.stringify` / `JSON.parse`                          | `System.Text.Json`                                                                                         |
| `undefined`, `===`, JS truthiness                        | `null`, `==`, explicit bools (`is not null`, `?.`)                                                         |
| `@class`, `:class`, `v-if`, `v-for` (Vue)                | `class`, `@if`, `@foreach`                                                                                 |
| `@Html.Raw` (MVC reflex)                                 | `@((MarkupString)html)`                                                                                    |
| `@functions { }` / `@helper` (legacy)                    | `@code { }` / a method in `@code` or a component                                                           |

## Correct idioms

- Components are **PascalCase tags** (`<ApprovalGate>`); HTML elements stay lowercase.
  Razor is case-sensitive — `@onclick` is not `@OnClick` or `onclick`.
- Directives: `@page "/route"`, `@inject`, `@implements IDisposable`, `@layout`, `@attribute`.
- `@code { }` for C#; event handlers are `async Task` — **never `async void`**.
- Two-way binding: `@bind` (defaults to `onchange`); component binding is
  `@bind-Value` + `[Parameter] Value` + `[Parameter] EventCallback<T> ValueChanged`.
- Event args are optional: `@onclick="(MouseEventArgs e) => ..."` only when needed.
- `@onclick:preventDefault` / `@onclick:stopPropagation` for the HTML event-modifier cases.
- Lists: `@key` on the foreach item with a stable identity (e.g. `run.Id`).
- Comments: `@* ... *@` (Razor) for anything internal, not `<!-- -->`.
- Forms: `EditForm` + `InputText`/`InputSelect` + `DataAnnotationsValidator` +
  `ValidationMessage` — not raw `<form>` + JS validation.
- Styling: CSS isolation (`.razor.css` beside the component); no global stylesheet edits.
- Async: never `@(await ...)` inline in markup — load into a field in
  `OnInitializedAsync`, render with `@if (loading)`.
- Bool attributes take expressions: `disabled="@(!canApprove)"`, `checked="@isChecked"`.
- Render mode (.NET 8+): interactive components declare `@rendermode`. Carnitas.Web is
  Blazor Server — no WASM; keep JS interop server-safe (events/`OnAfterRenderAsync`,
  never `OnInitialized*`).

## C# in `@code` — not JavaScript

- Collections: `List<T>` / `IEnumerable<T>` + LINQ (`Where/Select/Any`) — not
  `map/filter/reduce`.
- Null handling: `?.`, `??`, `is not null` — not truthiness.
- Strings: `$""` interpolation, `string.IsNullOrWhiteSpace`.
- Async: `Task`/`ValueTask` + `await` — no Promises, no callbacks.
- Strong typing throughout; `var` only for obvious locals.

## Pre-submit checklist (paste into every Blazor task)

1. No `<script>` anywhere in `.razor`.
2. No bare HTML event attributes — every handler starts with `@on` and points at a C# method/lambda.
3. No React: `className`, `useState`, `useEffect`, `useContext`, `props.`, `children`, `key=`, `style={{`, `onChange`.
4. No Vue/Angular: `@class`, `:attr`, `v-*`, `ng-*`.
5. No JSX braces `{x}` — Razor is `@x`; no `${...}`.
6. Components PascalCase, HTML lowercase, directives camelCase.
7. `@bind` used instead of `value` + `onchange` pairs.
8. Handlers `async Task`, never `async void`; no `@(await ...)` in markup.
9. `class` used (never `className`); dynamic classes via `@(...)` expressions.
10. Any JS interop is justified, module-based, and called from events/`OnAfterRenderAsync`.
