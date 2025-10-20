# StudyChain User Authentication System

## Overview
StudyChain now includes a comprehensive user authentication and authorization system with three distinct user roles: Admin, Premium, and Normal users.

## User Roles

### 1. Admin
- **Full system access** with all permissions
- Can manage all users through the Admin Panel
- Can change user roles
- Can delete users (except other admins)
- Access to system statistics and analytics
- Protected from deletion

**Default Admin Credentials:**
- Email: `admin@studychain.com`
- Password: `password123`

### 2. Premium Users
- **Full access** to all study features
- Can create, read, update, and delete:
  - Notes
  - Timers
  - Study Materials
  - Flashcard Collections
  - Agendas
  - Reminders
- Premium badge displayed in navigation

**Test Premium User:**
- Email: `premium@studychain.com`
- Password: `password123`

### 3. Normal Users
- **Limited access** to the platform
- Can view the home page
- Cannot access premium features
- Must upgrade to Premium for full functionality

**Test Normal User:**
- Email: `user@studychain.com`
- Password: `password123`

## Features

### Authentication Pages
- **Sign Up**: Beautiful, modern registration form with name, email, and password fields
- **Login**: Clean login interface with "Remember Me" option
- **Profile Management**: Users can update their name, email, and password

### Admin Panel
Admin users have access to a dedicated admin dashboard at `/admin`:

#### Dashboard Features:
- Total users count
- User role distribution (Admin, Premium, Normal)
- Content statistics (Notes, Timers, Study Materials, Flashcard Collections)
- User management interface

#### User Management:
- View all users in a sortable table
- Change user roles on the fly
- Delete users (with protection for admin accounts)
- Search and filter capabilities

### Authorization System
The system uses a robust authorization framework:

```ruby
# Helper Methods in ApplicationController
- require_authenticated_user  # Requires any logged-in user
- require_premium_or_admin    # Requires Premium or Admin role
- require_admin               # Requires Admin role only
```

### Protected Routes
All major features are protected:
- Notes: Premium + Admin
- Timers: Premium + Admin
- Study Materials: Premium + Admin
- Flashcard Collections: Premium + Admin
- Agendas: Premium + Admin
- Reminders: Premium + Admin
- Admin Panel: Admin only

## Setup Instructions

### Initial Setup
1. Run migrations:
   ```bash
   rails db:migrate
   ```

2. Seed the database with default users:
   ```bash
   rails db:seed
   ```

3. Start the server:
   ```bash
   rails server
   ```

### Creating Additional Users
Users can register through the signup page at `/users/sign_up`

### Promoting Users to Premium/Admin
Admins can change user roles through the Admin Panel at `/admin/users`

## Security Features

- **Password Encryption**: All passwords are encrypted using Devise's secure bcrypt algorithm
- **Session Management**: Secure session handling with "Remember Me" functionality
- **CSRF Protection**: Built-in Rails CSRF protection on all forms
- **Role Validation**: Server-side role checking prevents unauthorized access
- **Admin Protection**: Admin users cannot be deleted through the interface

## UI/UX Highlights

### Modern Authentication Design
- Gradient backgrounds for visual appeal
- Clean, card-based layouts
- Smooth animations and transitions
- Mobile-responsive design
- Clear error messages and validation feedback

### Navigation System
- Dynamic navigation based on user role
- User greeting with name display
- Role badges (Admin/Premium)
- Quick access to profile and logout
- Admin panel link for administrators

### Flash Messages
- Elegant toast-style notifications
- Auto-positioning for better visibility
- Success (green) and error (red) states
- Smooth slide-down animation

## Customization

### Changing Default Passwords
It's recommended to change the default seed passwords in production:

Edit `db/seeds.rb` and update the password values, then run:
```bash
rails db:seed
```

### Styling
All authentication styles are located in:
- `app/assets/stylesheets/devise.scss` - Authentication pages
- `app/assets/stylesheets/navigation.scss` - Navigation bar
- `app/assets/stylesheets/admin.scss` - Admin panel

### Adding New Roles
To add new roles, update the enum in `app/models/user.rb`:
```ruby
enum role: { normal: 0, premium: 1, admin: 2, new_role: 3 }
```

## Troubleshooting

### "You are not authorized" messages
- Check your user role in the database
- Ensure you're logged in
- Verify the route requires your role level

### Can't access Admin Panel
- Only Admin users can access `/admin`
- Check your role: `rails console` → `User.find_by(email: 'your@email.com').role`

### Forgot Admin Password
Reset via Rails console:
```ruby
admin = User.find_by(email: 'admin@studychain.com')
admin.update(password: 'newpassword123', password_confirmation: 'newpassword123')
```

## Future Enhancements

Potential features for future development:
- Email verification
- Password reset via email
- Two-factor authentication
- User activity logs
- Subscription management for Premium users
- User dashboard with personal statistics
- Social authentication (Google, Facebook)

## Support

For issues or questions, please contact the development team or check the main README.md file.

---

**Last Updated**: October 2025

