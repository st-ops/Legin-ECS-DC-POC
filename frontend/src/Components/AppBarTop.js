import React from 'react'
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import IconButton from '@material-ui/core/Button';
import AddIcon from '@material-ui/icons/Add';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles(theme => ({
    root: {
        flexGrow: 1,
    },
}));


export default function AppBarTop() {
    const classes = useStyles();

    return (
        <div className={classes.root}>
            <AppBar position="static" color="primary">
                <Toolbar>
                    <Typography variant="h6" color="inherit">
                        Shopping List
                    </Typography>
                    <IconButton edge="start" color="inherit" aria-label="Add">
                        <AddIcon />
                    </IconButton>
                </Toolbar>
            </AppBar>
        </div>
    );
}