enum TodoFilter {
  all('All'),
  active('Active'),
  completed('Done');

  const TodoFilter(this.label);
  final String label;
}
