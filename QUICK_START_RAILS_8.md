# Quick Start Guide - Rails 8 & Ruby 3.2.2

## 🎉 Upgrade Complete!

Your StudyChain application has been successfully upgraded to:
- **Ruby 3.2.2** (from 2.7.7)
- **Rails 8.0.3** (from 6.1.7)
- **Hotwire (Turbo + Stimulus)** (from Turbolinks + Webpacker)

## 🚀 Getting Started

### 1. Start the Development Server

The easiest way to run the application:

```bash
bin/dev
```

This will start both:
- Rails server on port 3000
- Dart Sass CSS compiler in watch mode

### 2. Visit Your Application

Open your browser and go to:
```
http://localhost:3000
```

### 3. Alternative: Manual Start

If you prefer to run services separately:

```bash
# Terminal 1: Rails server
rails server

# Terminal 2: CSS compilation
bin/rails dartsass:watch
```

## 📦 What Changed?

### JavaScript Management
- **Before:** Webpacker with Webpack
- **After:** Importmap (no build step needed!)

### Page Navigation
- **Before:** Turbolinks
- **After:** Turbo (more powerful, better UX)

### CSS Compilation
- **Before:** Sass Rails
- **After:** Dart Sass (faster, modern)

## 🔧 Common Commands

### Database
```bash
# Create database
rails db:create

# Run migrations
rails db:migrate

# Seed database
rails db:seed

# Reset database (careful!)
rails db:reset
```

### Console
```bash
# Open Rails console
rails console

# Or shorthand
rails c
```

### Routes
```bash
# View all routes
rails routes

# Search for specific route
rails routes | grep users
```

### Assets
```bash
# Precompile assets for production
rails assets:precompile

# Clean compiled assets
rails assets:clobber
```

## 💡 New Features You Can Use

### 1. Turbo Frames
Speed up your app by updating only parts of the page:

```erb
<%= turbo_frame_tag "messages" do %>
  <!-- Content here updates independently -->
<% end %>
```

### 2. Turbo Streams
Real-time updates without JavaScript:

```ruby
# In your controller
respond_to do |format|
  format.turbo_stream
  format.html
end
```

### 3. Stimulus Controllers
Add JavaScript behavior with minimal code:

```bash
# Generate a new Stimulus controller
rails generate stimulus hello
```

## 🎨 Styling

Your SCSS files are in:
```
app/assets/stylesheets/
```

They're automatically compiled when you run `bin/dev` or `bin/rails dartsass:watch`.

## 📝 Adding JavaScript Libraries

Use importmap to add JavaScript libraries:

```bash
# Search for a library
bin/importmap search jquery

# Add a library
bin/importmap pin jquery

# Update all pins
bin/importmap update
```

## 🔍 Troubleshooting

### Server won't start?
```bash
# Kill any existing Rails processes
pkill -9 -f puma

# Try again
bin/dev
```

### CSS not updating?
```bash
# Make sure Dart Sass is running
bin/rails dartsass:watch

# Or restart bin/dev
```

### JavaScript errors?
1. Check browser console (F12)
2. Verify `config/importmap.rb` has all needed pins
3. Clear browser cache (Cmd+Shift+R)

### Database issues?
```bash
# Check database status
rails db:migrate:status

# Run pending migrations
rails db:migrate
```

## <i class="fa-solid fa-book"></i> Documentation

- **Rails 8 Guide:** https://guides.rubyonrails.org/
- **Turbo Handbook:** https://turbo.hotwired.dev/
- **Stimulus Handbook:** https://stimulus.hotwired.dev/
- **Importmap:** https://github.com/rails/importmap-rails

## 🎯 Next Steps

1. ✅ Start the server: `bin/dev`
2. ✅ Test all features (see MIGRATION_CHECKLIST.md)
3. ✅ Check for console errors
4. ✅ Update any custom JavaScript
5. ✅ Deploy to staging/production

## 💬 Need Help?

Check these files for more details:
- `RAILS_8_UPGRADE_SUMMARY.md` - Complete upgrade details
- `MIGRATION_CHECKLIST.md` - Testing checklist
- `README.md` - General project documentation

## 🎊 Happy Coding!

Your application is now running on the latest Rails 8 with modern JavaScript tooling. Enjoy the improved performance and developer experience!

---

**Quick Reference:**
- Start server: `bin/dev`
- Rails console: `rails c`
- Database: `rails db:migrate`
- Routes: `rails routes`
- Tests: `rails test`

