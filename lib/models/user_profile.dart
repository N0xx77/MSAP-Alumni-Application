class UserProfile {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int graduationYear;
  final String department;
  final String currentRole;
  final String company;
  final String location;
  final String avatarUrl;
  final String bio;
  final String membershipStatus; // e.g. "Active", "Pending", "Expired"
  final String membershipId;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.graduationYear,
    required this.department,
    required this.currentRole,
    required this.company,
    required this.location,
    required this.avatarUrl,
    required this.bio,
    required this.membershipStatus,
    required this.membershipId,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    int? graduationYear,
    String? department,
    String? currentRole,
    String? company,
    String? location,
    String? avatarUrl,
    String? bio,
    String? membershipStatus,
    String? membershipId,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      graduationYear: graduationYear ?? this.graduationYear,
      department: department ?? this.department,
      currentRole: currentRole ?? this.currentRole,
      company: company ?? this.company,
      location: location ?? this.location,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      membershipStatus: membershipStatus ?? this.membershipStatus,
      membershipId: membershipId ?? this.membershipId,
    );
  }
}
