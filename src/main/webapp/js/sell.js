 // Toggle FAQ answers
 document.querySelectorAll('.faq-question').forEach(question => {
    question.addEventListener('click', () => {
        const faqItem = question.parentElement;
        faqItem.classList.toggle('active');
    });
});

// Form submission handler
document.getElementById('sellPropertyForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    // In a real implementation, you would send data to server
    // For demo purposes, we'll just show an alert
    alert('Thank you for submitting your property listing! Our team will contact you shortly.');
    this.reset();
});