# Rails 8 Migration Checklist

## ✅ Pre-Migration (Completed)
- [x] Backup database
- [x] Commit all changes to git
- [x] Document current Ruby/Rails versions

## ✅ Core Upgrade (Completed)
- [x] Update Ruby to 3.2.2
- [x] Update Rails to 8.0.3
- [x] Update Gemfile dependencies
- [x] Run bundle install
- [x] Remove Webpacker
- [x] Install Importmap
- [x] Install Turbo Rails
- [x] Install Stimulus
- [x] Update configuration files
- [x] Update bin scripts
- [x] Update views for Turbo

## 🔍 Testing Checklist

### Authentication & User Management
- [ ] Test user registration
- [ ] Test user login
- [ ] Test user logout
- [ ] Test password reset
- [ ] Test email verification
- [ ] Test admin panel access
- [ ] Test user profile editing

### Core Features
- [ ] Test Notes CRUD operations
- [ ] Test Timers functionality
- [ ] Test Pomodoro timer
- [ ] Test Study Materials upload/download
- [ ] Test Flashcard Collections
- [ ] Test Flashcards creation/editing
- [ ] Test Agenda/Calendar
- [ ] Test Reminders

### UI/UX
- [ ] Test theme switcher (light/dark mode)
- [ ] Test navigation menu
- [ ] Test flash messages
- [ ] Test responsive design
- [ ] Test all forms submission
- [ ] Test all links and buttons

### JavaScript & Assets
- [ ] Verify all JavaScript loads correctly
- [ ] Verify all CSS styles are applied
- [ ] Verify images load correctly
- [ ] Test Turbo navigation (no full page reloads)
- [ ] Check browser console for errors

### Email
- [ ] Test email sending in development
- [ ] Verify email templates render correctly
- [ ] Test letter_opener integration

## 🐛 Common Issues & Solutions

### Issue: "Sprockets::FileNotFound"
**Solution:** Run `rails assets:precompile` or restart the server

### Issue: JavaScript not loading
**Solution:** 
1. Check `config/importmap.rb` has all necessary pins
2. Run `bin/importmap pin [library-name]` if missing
3. Clear browser cache

### Issue: CSS not compiling
**Solution:**
1. Make sure `bin/rails dartsass:watch` is running
2. Or use `bin/dev` to run both Rails and CSS compilation
3. Check `app/assets/stylesheets/` for syntax errors

### Issue: Turbo breaking forms
**Solution:**
1. Add `data-turbo="false"` to forms that need full page reload
2. Or update forms to return turbo_stream responses

### Issue: Devise redirects not working
**Solution:**
- Already configured: `config.navigational_formats = ['*/*', :html, :turbo_stream]`
- If issues persist, check Devise controllers

### Issue: "LoadError: cannot load such file"
**Solution:**
1. Run `bundle install` again
2. Restart the Rails server
3. Check if gem is in Gemfile

## 📝 Development Workflow

### Starting Development Server
```bash
# Recommended: Runs Rails + CSS compilation
bin/dev

# Or manually:
# Terminal 1
rails server

# Terminal 2
bin/rails dartsass:watch
```

### Adding New JavaScript Libraries
```bash
# Search for available packages
bin/importmap search library-name

# Pin a package
bin/importmap pin library-name

# Update pins
bin/importmap update
```

### Compiling Assets for Production
```bash
RAILS_ENV=production rails assets:precompile
```

## 🚀 Deployment Checklist

- [ ] Test application thoroughly in development
- [ ] Run all tests: `rails test`
- [ ] Precompile assets: `rails assets:precompile RAILS_ENV=production`
- [ ] Update production environment variables
- [ ] Deploy to staging first
- [ ] Test on staging
- [ ] Deploy to production
- [ ] Monitor logs for errors
- [ ] Test critical user flows in production

## 📚 Key Changes to Remember

1. **Turbolinks → Turbo**: Update event listeners
   ```javascript
   // Old
   document.addEventListener('turbolinks:load', ...)
   
   // New
   document.addEventListener('turbo:load', ...)
   ```

2. **Remote Forms**: Use Turbo Streams
   ```erb
   <%# Old %>
   <%= form_with model: @user, remote: true %>
   
   <%# New (Turbo handles this automatically) %>
   <%= form_with model: @user %>
   ```

3. **JavaScript Imports**: Use ES6 modules
   ```javascript
   // In config/importmap.rb
   pin "application"
   pin "@hotwired/turbo-rails", to: "turbo.min.js"
   
   // In app/javascript/application.js
   import "@hotwired/turbo-rails"
   ```

4. **CSS Compilation**: Use Dart Sass
   ```bash
   # Watch mode for development
   bin/rails dartsass:watch
   
   # One-time build
   bin/rails dartsass:build
   ```

## 🆘 Getting Help

If you encounter issues:
1. Check Rails 8.0 release notes
2. Check Hotwire documentation
3. Search GitHub issues for similar problems
4. Check the upgrade summary document

## ✅ Sign-off

- [ ] All features tested and working
- [ ] No console errors
- [ ] All tests passing
- [ ] Documentation updated
- [ ] Team notified of changes
- [ ] Ready for production deployment

---

**Last Updated:** October 26, 2025

