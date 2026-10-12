enum LeadershipCategory {
  officeBearer,
  executiveMember,
  advisoryBoard,
}

class LeadershipMember {
  final String id;
  final String name;
  final String role;
  final String imagePath;
  final LeadershipCategory category;

  const LeadershipMember({
    required this.id,
    required this.name,
    required this.role,
    required this.imagePath,
    this.category = LeadershipCategory.executiveMember,
  });
}
