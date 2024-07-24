/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class AccountSummary {
  /// Creates the employee class with required details.
  AccountSummary(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}
