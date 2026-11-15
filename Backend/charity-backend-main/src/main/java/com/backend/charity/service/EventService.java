package com.backend.charity.service;

import com.backend.charity.model.Event;
import com.backend.charity.model.User;
import com.backend.charity.repository.EventRepository;
import com.backend.charity.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventService {
    @Autowired
    private EventRepository eventRepository;
    @Autowired
    private UserRepository userRepository;

    public Event addEvent(Event event) {
        return eventRepository.save(event);
    }

    public Event updateEvent(Long id, Event newEvent) {
        return eventRepository.findById(id).map(event -> {
            event.setTitle(newEvent.getTitle());
            event.setDescription(newEvent.getDescription());
            event.setLocation(newEvent.getLocation());
            event.setDate(newEvent.getDate());
            event.setTime(newEvent.getTime());
            event.setDonations(newEvent.getDonations());
            return eventRepository.save(event);
        }).orElseThrow(() -> new RuntimeException("Event not found"));
    }
    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }

    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }
    public List<Event> getAllEventsByIdAsscoiation(Long id) {
        return eventRepository.getEventByAssociationId(id);
    }
}

