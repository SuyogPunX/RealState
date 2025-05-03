document.addEventListener('DOMContentLoaded', function() {
    // DOM elements
    const bookingForm = document.getElementById('bookingForm');
    const bookingsList = document.getElementById('bookingsList');
    const noBookings = document.getElementById('noBookings');
    const notification = document.getElementById('notification');
    const clearBtn = document.getElementById('clearBtn');
    const bookingIdInput = document.getElementById('bookingId');
    const submitBtn = document.getElementById('submitBtn');

    // Generate a random booking ID
    function generateBookingId() {
        return 'BK-' + Math.floor(100000 + Math.random() * 900000);
    }

    // Set initial booking ID
    bookingIdInput.value = generateBookingId();

    // Load bookings from localStorage
    let bookings = JSON.parse(localStorage.getItem('bookings')) || [];
    
    // Display bookings
    function displayBookings() {
        if (bookings.length === 0) {
            noBookings.style.display = 'block';
            return;
        }
        
        noBookings.style.display = 'none';
        bookingsList.innerHTML = '';
        
        // Sort bookings by date (newest first)
        bookings.sort((a, b) => new Date(b.meetingDate) - new Date(a.meetingDate));
        
        bookings.forEach((booking, index) => {
            const row = document.createElement('tr');
            
            // Format date for display
            const meetingDate = new Date(booking.meetingDate);
            const formattedDate = meetingDate.toLocaleDateString() + ' ' + 
                                 meetingDate.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
            
            row.innerHTML = `
                <td>${booking.bookingId}</td>
                <td>${formattedDate}</td>
                <td>${booking.meetingLocation}</td>
                <td>${booking.propertyId}</td>
                <td>${booking.customerId}</td>
                <td><span class="status status-${booking.outcome}">${booking.outcome.charAt(0).toUpperCase() + booking.outcome.slice(1)}</span></td>
                <td>
                    <button class="action-btn edit" data-id="${index}">✏️</button>
                    <button class="action-btn delete" data-id="${index}">🗑️</button>
                </td>
            `;
            bookingsList.appendChild(row);
        });
        
        // Add event listeners to edit and delete buttons
        document.querySelectorAll('.edit').forEach(btn => {
            btn.addEventListener('click', editBooking);
        });
        
        document.querySelectorAll('.delete').forEach(btn => {
            btn.addEventListener('click', deleteBooking);
        });
    }
    
    // Display initial bookings
    displayBookings();
    
    // Form submission
    bookingForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(bookingForm);
        const bookingData = {
            bookingId: formData.get('bookingId'),
            meetingDate: formData.get('meetingDate'),
            meetingLocation: formData.get('meetingLocation'),
            outcome: formData.get('outcome'),
            propertyId: formData.get('propertyId'),
            customerId: formData.get('customerId'),
            notes: formData.get('notes')
        };
        
        // Check if we're editing an existing booking
        const editIndex = submitBtn.dataset.editIndex;
        
        if (editIndex !== undefined) {
            // Update existing booking
            bookings[editIndex] = bookingData;
            showNotification('Booking updated successfully!', 'success');
            submitBtn.textContent = 'Schedule Meeting';
            submitBtn.removeAttribute('data-edit-index');
        } else {
            // Add new booking
            bookings.push(bookingData);
            showNotification('Meeting scheduled successfully!', 'success');
        }
        
        // Save to localStorage
        localStorage.setItem('bookings', JSON.stringify(bookings));
        
        // Refresh bookings display
        displayBookings();
        
        // Clear form
        clearForm();
    });
    
    // Edit booking
    function editBooking(e) {
        const bookingIndex = e.target.dataset.id;
        const booking = bookings[bookingIndex];
        
        // Fill form with booking data
        bookingIdInput.value = booking.bookingId;
        document.getElementById('meetingDate').value = booking.meetingDate;
        document.getElementById('meetingLocation').value = booking.meetingLocation;
        document.getElementById('outcome').value = booking.outcome;
        document.getElementById('propertyId').value = booking.propertyId;
        document.getElementById('customerId').value = booking.customerId;
        document.getElementById('notes').value = booking.notes || '';
        
        // Change submit button to update
        submitBtn.textContent = 'Update Meeting';
        submitBtn.dataset.editIndex = bookingIndex;
        
        // Scroll to form
        document.querySelector('.booking-form').scrollIntoView({ behavior: 'smooth' });
    }
    
    // Delete booking
    function deleteBooking(e) {
        if (confirm('Are you sure you want to delete this booking?')) {
            const bookingIndex = e.target.dataset.id;
            bookings.splice(bookingIndex, 1);
            
            // Save to localStorage
            localStorage.setItem('bookings', JSON.stringify(bookings));
            
            // Refresh bookings display
            displayBookings();
            
            showNotification('Booking deleted successfully!', 'success');
        }
    }
    
    // Clear form
    function clearForm() {
        bookingForm.reset();
        bookingIdInput.value = generateBookingId();
        submitBtn.textContent = 'Schedule Meeting';
        submitBtn.removeAttribute('data-edit-index');
    }
    
    // Clear button event
    clearBtn.addEventListener('click', clearForm);
    
    // Show notification
    function showNotification(message, type) {
        notification.textContent = message;
        notification.className = 'notification ' + type;
        notification.style.display = 'block';
        
        // Hide notification after 3 seconds
        setTimeout(() => {
            notification.style.display = 'none';
        }, 3000);
    }
});