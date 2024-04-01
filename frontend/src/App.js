import React, { Component } from 'react';
import './App.css';
import AppBarTop from './Components/AppBarTop';
import MaterialTable from 'material-table';


class App extends Component {

  state = {
    data: []
  }

  componentDidMount() {
    this.getProducts();
  }

  getProducts = _ => {
    fetch('http://localhost:4000/api/products')
    .then(response => response.json())
    .then(response => this.setState({ data: response.data }))
    .catch(err => console.error(err))
  }


  render() {
    const { data } = this.state;

    return (
      <div className="App">
        <AppBarTop />
        <MaterialTable title="Products"
        columns={[
          { title: 'Name', field: 'name' },
          { title: 'Amount', field: 'amount' },
          { title: 'Price', field: 'price' },
        ]}
        data={() =>
          new Promise((resolve, reject) => {
            let url = 'http://localhost:4000/api/products'
            fetch(url)
            .then(response => response.json())
            .then(result => {
              resolve({
                data: result.data,
              })
            })
          })
        }
        editable={{
          onRowAdd: newData =>
            new Promise((resolve, reject) => {
              let url = 'http://localhost:4000/api/products/add?'
              url += 'name=' + newData.name
              url += '&price=' + newData.price
              url += '&amount=' + newData.amount
              fetch(url)
              .then(result => {
                resolve({
                  data: result.newData
                })
              })
            }),
          onRowDelete: oldData =>
            new Promise((resolve, reject) => {
              let url = 'http://localhost:4000/api/products/'
              url += oldData.product_id
              fetch(url)
              .then(result => {
                resolve({
                  data: result.oldData
                })
              })
            }),
        }}
        options={{
          search: true
        }}
        />
      </div>
    );
  }
}

export default App;
