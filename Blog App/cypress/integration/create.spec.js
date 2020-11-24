/* eslint-disable no-undef */
/* globals Cypress cy */
describe('CI test for creating a blog', () => {
  // refactor with a beforeEach for cy.visit command
  it('should open the homepage and click the create blog button to open the create page', () => {
    cy.visit(Cypress.env('HOST'));
    cy.get('.navbar').should('be.visible');
    cy.get('.float-right').click({ force: true });
    cy.url().should('include', '/create');
    cy.get('#blogTitle').should('be.visible');
    cy.get('#blogContent').should('be.visible');
  });

  it('should create a new blog and see the name of the new blog appear in the blog list on the homepage', () => {
    cy.visit(Cypress.env('HOST'));
    cy.get('.navbar').should('be.visible');
    cy.get('.float-right').click({ force: true });
    cy.get('#blogTitle').should('be.visible');
    cy.get('#blogContent').should('be.visible');
    cy.get('#blogTitle').type('New Blog');
    cy.get('#blogContent').type('This is my new blog.');
    cy.get('form > .btn').click({ force: true });
    cy.get('[href="/blog/New Blog"] > h2').should('be.visible').click({ force: true });
    cy.get('.text-left > .btn').click({ force: true });
  });
});
