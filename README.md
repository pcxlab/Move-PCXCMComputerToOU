﻿# Move-PCXCMComputerToOU
The terms CN (Common Name) and OU (Organizational Unit) are both components of distinguished names (DN) in Active Directory, but they serve different purposes in the hierarchy:

1. CN (Common Name):
What it is: CN refers to the name of an individual object within Active Directory (AD). It is used to uniquely identify a specific object, such as a user, group, or computer.

Usage: CN is usually the leaf of the distinguished name (DN) and represents an individual item.

Example: For a computer object or a user object, the CN would represent that computer or user.

Example Distinguished Name (DN) for a user:

makefile
Copy code
CN=John Doe,OU=Users,DC=corp,DC=pcxlab,DC=com
Here, CN=John Doe refers to the specific user "John Doe."
2. OU (Organizational Unit):
What it is: OU refers to an Organizational Unit, which is a container within Active Directory. OUs are used to organize and group objects such as users, computers, and groups into hierarchical structures for easier management and delegation of permissions.

Usage: OUs can contain multiple objects (users, computers, groups) or even other OUs, creating a hierarchy. OUs are typically used for administrative purposes, such as applying group policies or delegating control over certain objects.

Example Distinguished Name (DN) for an Organizational Unit:

makefile
Copy code
OU=IT Department,DC=corp,DC=pcxlab,DC=com
Here, OU=IT Department is an Organizational Unit that likely contains objects (users, computers, groups) related to the IT department.
Key Differences:
Aspect	CN (Common Name)	OU (Organizational Unit)
Purpose	Identifies a single object (user, computer, etc.)	Organizes objects into a container (e.g., groups of users, computers)
Position	Leaf of the DN, represents the actual object	Intermediate container that can contain other OUs or objects
Scope	Individual objects (user, computer, group)	Collection of objects or other OUs
Example	CN=John Doe (user), CN=PC01 (computer)	OU=HR Department, OU=IT Department
Management Role	No inherent hierarchy, just an object name	Used to organize AD hierarchy and assign group policies
Conclusion:
CN is used to refer to individual objects like users or computers.
OU is a container used to group and manage multiple objects or even other OUs.
Both are essential in managing Active Directory, but they serve different roles in organizing and identifying objects within the AD hierarchy.
