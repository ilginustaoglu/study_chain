# StudyChain <i class="fa-solid fa-book"></i>

A comprehensive study management platform built with Ruby on Rails, designed to help students organize their learning journey with powerful tools and features.

## Features

### 📝 Note Management
- Create, edit, and organize study notes
- Rich text content support
- Quick note creation and editing
- Search and filter capabilities

### <i class="fa-solid fa-clock"></i> Pomodoro Timers
- Multiple customizable timers
- Pomodoro technique support
- Start, pause, and reset functionality
- Alarm notifications

### 📖 Study Materials
- Upload and organize study materials
- File attachment support
- Categorization by subject
- Easy access to learning resources

### 🎴 Flashcard Collections
- Create flashcard collections for different topics
- Add multiple flashcards per collection
- Study mode for effective learning
- Track your progress

### 📅 Agenda & Calendar
- Plan your study schedule
- Event management with dates
- Stay organized with upcoming tasks

### ⏰ Reminders
- Set study reminders
- Toggle alarm status
- Never miss important study sessions

### 👥 User Authentication & Authorization
StudyChain includes a complete user management system with three user roles:

- **Admin**: Full system access with user management capabilities
- **Premium**: Access to all study features
- **Normal**: Limited access with option to upgrade

For detailed information, see [USER_AUTHENTICATION.md](USER_AUTHENTICATION.md)

## Tech Stack

- **Framework**: Ruby on Rails 8.0
- **Ruby Version**: 3.2.2
- **Database**: PostgreSQL
- **Authentication**: Devise
- **Frontend**: Hotwire (Turbo + Stimulus) with Importmap
- **Styling**: SCSS with Dart Sass and modern gradients and animations
- **JavaScript**: Vanilla JS with Turbo

## Setup Instructions

### Prerequisites
- Ruby 3.2.2
- PostgreSQL
- Node.js (for Dart Sass compilation)

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/study_chain.git
   cd study_chain
   ```

2. Install dependencies
   ```bash
   bundle install
   npm install
   ```

3. Setup database
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the development server
   ```bash
   bin/dev
   ```
   
   Or manually start Rails and CSS compilation:
   ```bash
   rails server
   # In another terminal:
   bin/rails dartsass:watch
   ```

5. Visit `http://localhost:3000`

### Default Users (after seeding)

- **Admin**: admin@studychain.com / password123
- **Premium**: premium@studychain.com / password123
- **Normal**: user@studychain.com / password123

## Project Structure

```
app/
├── controllers/     # Application controllers
├── models/         # ActiveRecord models
├── views/          # ERB templates
├── assets/         # Stylesheets and images
├── javascript/     # JavaScript files
└── helpers/        # View helpers

config/
├── routes.rb       # Application routes
└── initializers/   # Configuration files

db/
├── migrate/        # Database migrations
└── seeds.rb        # Seed data
```

## Key Models

- **User**: Authentication and role management
- **Note**: Study notes
- **Timer**: Pomodoro timers
- **StudyMaterial**: Uploaded study resources
- **FlashcardCollection**: Flashcard sets
- **Flashcard**: Individual flashcards
- **Agenda**: Calendar events
- **Reminder**: Study reminders

## Admin Panel

Administrators have access to a powerful admin dashboard:
- User management
- Role assignment
- System statistics
- Content overview

Access at: `/admin`

## Development

### Running Tests
```bash
rails test
```

### Code Style
This project follows standard Ruby and Rails conventions.

### Database Migrations
```bash
# Create a new migration
rails generate migration MigrationName

# Run migrations
rails db:migrate

# Rollback
rails db:rollback
```

## Deployment

### Production Setup
1. Set environment variables
2. Precompile assets: `rails assets:precompile`
3. Run migrations: `rails db:migrate RAILS_ENV=production`
4. Start the server with your preferred method (Puma, Passenger, etc.)

## Features in Detail

### Authentication System
- Secure password encryption
- Session management
- Remember me functionality
- Profile management
- Role-based access control

### Modern UI/UX
- Gradient designs
- Smooth animations
- Responsive layouts
- Mobile-friendly interface
- Toast notifications
- Dark mode ready

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is private and proprietary.

## Support

For support, please contact the development team or open an issue in the repository.

## Roadmap

### Upcoming Features
- [ ] Email verification
- [ ] Password reset via email
- [ ] Study statistics and analytics
- [ ] Collaborative study groups
- [ ] Mobile applications
- [ ] API for third-party integrations
- [ ] Advanced flashcard algorithms
- [ ] Study streak tracking

## Acknowledgments

Built with ❤️ using Ruby on Rails and modern web technologies.

---

**Version**: 1.0.0  
**Last Updated**: October 2025
