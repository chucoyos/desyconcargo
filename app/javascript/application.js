// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Toast notifications
document.addEventListener("turbo:load", function() {
  // Auto-hide toasts after 5 seconds
  setTimeout(function() {
    const toasts = document.querySelectorAll('.toast');
    toasts.forEach(function(toast) {
      toast.style.transform = 'translateX(100%)';
      setTimeout(function() {
        toast.remove();
      }, 300);
    });
  }, 5000);

  // Handle toast close buttons
  document.addEventListener('click', function(event) {
    if (event.target.closest('.toast-close')) {
      const toast = event.target.closest('.toast');
      toast.style.transform = 'translateX(100%)';
      setTimeout(function() {
        toast.remove();
      }, 300);
    }
  });
});
